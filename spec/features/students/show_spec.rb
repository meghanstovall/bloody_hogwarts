require 'rails_helper'

RSpec.describe "students show page" do
  it "can see a list of their student course" do
    student_1 = Student.create({name: "Harry",
                              age: "25",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "25",
                              house: "Gryffindor"})
    course_1 = student_1.courses.create(name: "Potions")
    course_2 = student_1.courses.create(name: "Defense against the Dark Arts")
    course_3 = student_1.courses.create(name: "Herbology")

    visit "/students/#{student_1.id}"

    expect(page).to have_content("Courses:")
    expect(page).to have_content(course_1.name)
    expect(page).to have_content(course_2.name)
    expect(page).to have_content(course_3.name)
  end
end
