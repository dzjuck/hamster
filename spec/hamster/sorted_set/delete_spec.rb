require "spec_helper"
require "hamster/sorted_set"

describe Hamster::SortedSet do
  describe "#delete" do
    before do
      @original = Hamster.sorted_set("A", "B", "C")
    end

    context "with an existing value" do
      before do
        @result = @original.delete("B")
      end

      it "preserves the original" do
        @original.should == Hamster.sorted_set("A", "B", "C")
      end

      it "returns a copy with the remaining of values" do
        @result.should == Hamster.sorted_set("A", "C")
      end
    end

    context "with a non-existing value" do
      before do
        @result = @original.delete("D")
      end

      it "preserves the original values" do
        @original.should == Hamster.sorted_set("A", "B", "C")
      end

      it "returns self" do
        @result.should equal(@original)
      end
    end

    context "when removing the last value in a sorted set" do
      before do
        @result = @original.delete("B").delete("C").delete("A")
      end

      it "returns the canonical empty set" do
        @result.should be(Hamster::EmptySortedSet)
      end
    end
  end
end