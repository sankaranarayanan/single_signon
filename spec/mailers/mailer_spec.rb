require "spec_helper"

describe Mailer, :redis do
  describe "#welcome" do
    let(:user) { create :user, name: 'sam'}

    subject do
      Mailer.welcome(user.attributes).deliver
    end

    it "should have email body" do
      subject.body.should include(user.name)
    end

    it { should have_sent_email.with_subject(I18n.t('.mailer.welcome.subject')) }

    it 'set correct recipients in X-SMTAPI header' do
      subject.header.to_s.should include("X-SMTPAPI: {\"to\":[\"#{user.email}\"]}")
    end
  end

  context "#password reset" do
    let(:identity) { create :identity, password_reset_token: "123456" }
    let(:user) { create :user, email: identity.email }

    subject do
      user.save
      mailer_params = user.attributes.merge(:redirect_uri => "http://fakeweb.com", :password_reset_token => identity.password_reset_token)
      Mailer.password_reset(mailer_params).deliver
    end

    it 'set correct recipients in X-SMTAPI header' do
      subject.header.to_s.should include("X-SMTPAPI: {\"to\":[\"#{user.email}\"]}")
    end

    it "should have email body" do
      subject.body.should include("/passwords/123456/edit?redirect_uri=#{CGI.escape('http://fakeweb.com')}")
    end

    it "should have email subject" do
      subject.subject.should include("Forgot Password")
    end
  end

  describe "queue" do
    it "defaults to the 'mailer' queue" do
      Mailer.queue.should == :default
    end
  end

  describe 'perform' do
    it 'should perform a queued mailer job' do
      user = create :user
      MAILER_PARAMS = {:klass => "Mailer", :method => "welcome", :args => [user.attributes]}
      lambda {
        Mailer.perform(MAILER_PARAMS)
      }.should change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end

  describe '#deliver' do
    it 'should deliver the email synchronously' do
      @user = create :user
      lambda { Mailer.welcome(@user.attributes).deliver }.should change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end

  describe '#queue' do
    before(:all) do
      @user = create :user
      @delivery = lambda {
        Mailer.enqueue.welcome(@user.attributes)
      }
    end

    it 'should not deliver the email synchronously' do
      lambda { @delivery.call }.should_not change(ActionMailer::Base.deliveries, :size)
    end

    it 'should place the deliver action on the Resque "mailer" queue' do
      Resque.should_receive(:enqueue).with(MailQueue, {:klass=>"Mailer", :method=>:welcome, :args=> [@user.attributes]})
      @delivery.call
    end
  end
end
