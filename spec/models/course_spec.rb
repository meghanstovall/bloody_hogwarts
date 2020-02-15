require 'rails_helper'

RSpec.describe Course, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :student_courses}
    it {should have_many(:students).through(:student_courses)}
  end

  describe '#student_count' do
    it "can return number of students" do
      course_1 = Course.create(name: "Potions")
      student_1 = course_1.students.create({name: "Harry",
                                age: "19",
                                house: "Gryffindor"})
      student_2 = course_1.students.create({name: "Herminy",
                                age: "20",
                                house: "Gryffindor"})
      student_3 = course_1.students.create({name: "Harry",
                                age: "25",
                                house: "Gryffindor"})
      student_4 = course_1.students.create({name: "Herminy",
                                age: "22",
                                house: "Gryffindor"})

      expect(course_1.student_count).to eq(4)
    end
  end

  describe "#ordered" do
    it "can return alphabetized array of students" do
      course_1 = Course.create(name: "Potions")
      course_2 = Course.create(name: "Defense Against the Dark Arts")
      course_3 = Course.create(name: "Herbology")

      expect(Course.ordered).to eq([course_2, course_3, course_1])
    end
  end
end
