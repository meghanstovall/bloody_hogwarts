require 'rails_helper'

RSpec.describe "course index page" do
  it "can see list of courses and a number of students" do
    student_1 = Student.create({name: "Harry",
                              age: "25",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "25",
                              house: "Gryffindor"})
    student_3 = Student.create({name: "Draco",
                              age: "20",
                              house: "Slitherin"})
    course_1 = Course.create(name: "Potions")
    course_2 = Course.create(name: "Defense Against the Dark Arts")
    course_3 = Course.create(name: "Herbology")
    course_1.students << student_1
    course_1.students << student_2
    course_1.students << student_3
    course_2.students << student_2
    course_2.students << student_3

    visit "/courses"

    expect(page).to have_content("#{course_1.name}: 3")
    expect(page).to have_content("#{course_2.name}: 2")
    expect(page).to have_content("#{course_3.name}: 0")
  end

  it "can display courses in alphabetical order" do
    course_1 = Course.create(name: "Potions")
    course_2 = Course.create(name: "Defense Against the Dark Arts")
    course_3 = Course.create(name: "Herbology")

    visit "/courses"

    expect(page).to have_content(course_2.name)
    expect(page).to have_content(course_3.name)
    expect(page).to have_content(course_1.name)
  end

  it "can show students for that course in alphabetical order" do
    student_1 = Student.create({name: "Harry",
                              age: "25",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "25",
                              house: "Gryffindor"})
    student_3 = Student.create({name: "Draco",
                              age: "20",
                              house: "Slitherin"})
    course_1 = Course.create(name: "Potions")
    course_2 = Course.create(name: "Defense Against the Dark Arts")
    course_3 = Course.create(name: "Herbology")

    course_1.students << student_1
    course_1.students << student_2
    course_1.students << student_3

    course_2.students << student_2
    course_2.students << student_3

    visit "/courses"
save_and_open_page
    within "#course-#{course_1.id}" do
      expect(page).to have_content(student_3.name)
      expect(page).to have_content(student_1.name)
      expect(page).to have_content(student_2.name)
    end

    within "#course-#{course_2.id}" do
      expect(page).to have_content(student_3.name)
      expect(page).to have_content(student_2.name)
    end
  end
end
