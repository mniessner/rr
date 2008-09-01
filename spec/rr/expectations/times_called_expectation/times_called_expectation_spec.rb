require File.expand_path("#{File.dirname(__FILE__)}/../../../spec_helper")

module RR
  module Expectations
    describe TimesCalledExpectation, " with failure" do
      it_should_behave_like "RR::Expectations::TimesCalledExpectation"
      attr_reader :times, :matcher

      before do
        @times = 0
        @matcher = TimesCalledMatchers::IntegerMatcher.new(times)
        @expectation = TimesCalledExpectation.new(double, matcher)
      end

      describe "#attempt!" do
        it "raises error that includes the double" do
          lambda {expectation.attempt}.should raise_error(
            Errors::TimesCalledError,
            "#{double.formatted_name}\n#{matcher.error_message(1)}"
          )
        end
      end

      describe "#verify!" do
        it "raises error with passed in message prepended" do
          expectation.instance_variable_set(:@times_called, 1)
          lambda {expectation.verify!}.should raise_error(
            Errors::TimesCalledError,
            "#{double.formatted_name}\n#{matcher.error_message(1)}"
          )
        end
      end
    end

  end
end
