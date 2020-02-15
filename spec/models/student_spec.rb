require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :house}
  end

  describe 'relationships' do
    it {should have_many :student_courses}
    it {should have_many(:courses).through(:student_courses)}
  end

  describe '#average_age' do
    it "can find average age of students" do
      course_1 = Course.create(name: "Potions")
      student_1 = Student.create({name: "Harry",
                                age: "19",
                                house: "Gryffindor"})
      student_2 = Student.create({name: "Herminy",
                                age: "20",
                                house: "Gryffindor"})
      student_3 = Student.create({name: "Harry",
                                age: "25",
                                house: "Gryffindor"})
      student_4 = Student.create({name: "Herminy",
                                age: "22",
                                house: "Gryffindor"})

      course_1.students << student_1
      course_1.students << student_2
      course_1.students << student_3
      course_1.students << student_4

      expect(course_1.students.average_age).to eq(21.5)
    end
  end

  describe "#ordered" do
    it "can return alphabetized array of students" do
      course_1 = Course.create(name: "Potions")
      student_1 = Student.create({name: "Harry",
                                age: "19",
                                house: "Gryffindor"})
      student_2 = Student.create({name: "Herminy",
                                age: "20",
                                house: "Gryffindor"})
      student_3 = Student.create({name: "Draco",
                                age: "25",
                                house: "Gryffindor"})

      course_1.students << student_1
      course_1.students << student_2
      course_1.students << student_3

      expect(course_1.students.ordered).to eq([student_3, student_1, student_2])
    end
  end
end
