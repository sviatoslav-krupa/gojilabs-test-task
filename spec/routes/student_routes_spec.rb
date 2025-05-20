require 'rails_helper'

RSpec.describe "Student routes", type: :routing do
  it "routes GET /students/:id/schedule to students#schedule" do
    expect(get: "/students/1/schedule").to route_to(
                                             controller: "students",
                                             action: "schedule",
                                             id: "1"
                                           )
  end

  it "generates helper path student_schedule_path" do
    expect(student_schedule_path(1)).to eq("/students/1/schedule")
  end
end
