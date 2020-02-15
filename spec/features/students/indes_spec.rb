require 'rails_helper'

RSpec.describe "students index page" do
  it "can see list of students" do
    student_1 = Student.create({name: "Harry",
                              age: "25",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "25",
                              house: "Gryffindor"})

    visit "/students"

    expect(page).to have_content("All Students")
    expect(page).to have_content("Name: #{student_1.name}")
    expect(page).to have_content("Age: #{student_1.age}")
    expect(page).to have_content("House: #{student_1.house}")
    expect(page).to have_content("Name: #{student_2.name}")
    expect(page).to have_content("Age: #{student_2.age}")
    expect(page).to have_content("House: #{student_2.house}")
  end

  it "can see average age of all students" do
    student_1 = Student.create({name: "Harry",
                              age: "18",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "20",
                              house: "Gryffindor"})
    student_3 = Student.create({name: "Draco",
                              age: "22",
                              house: "Slitherin"})

    visit "/students"

    expect(page).to have_content("Average Age of Students: 20.0")
  end

  it "can show students in alphabetical order" do
    student_1 = Student.create({name: "Harry",
                              age: "18",
                              house: "Gryffindor"})
    student_2 = Student.create({name: "Herminy",
                              age: "20",
                              house: "Gryffindor"})
    student_3 = Student.create({name: "Draco",
                              age: "22",
                              house: "Slitherin"})
    visit "/students"

    expect(page).to have_content("Name: #{student_3.name}")
    expect(page).to have_content("Name: #{student_1.name}")
    expect(page).to have_content("Name: #{student_2.name}")
  end
end
