require 'rails_helper'

RSpec.describe "StudentsRoutes", type: :routing do
  describe "Routing to enrollments through students" do
    let(:student_id) { '1' }
    let(:section_id) { '1' }

    it "routes GET /students/:id/schedule to students#schedule" do
      expect(get: "/students/#{student_id}/schedule").to route_to(
                                                           controller: "students",
                                                           action: "schedule",
                                                           id: student_id
                                                         )
    end

    it "routes POST /students/:id/enroll to enrollments#create" do
      expect(post: "/students/#{student_id}/enroll").to route_to(
                                                          controller: "enrollments",
                                                          action: "create",
                                                          id: student_id
                                                        )
    end

    it "routes DELETE /students/:id/drop to enrollments#destroy" do
      expect(delete: "/students/#{student_id}/drop").to route_to(
                                                          controller: "enrollments",
                                                          action: "destroy",
                                                          id: student_id
                                                        )
    end

    it "does not route to standard CRUD actions" do
      expect(get: "/students").not_to be_routable
      expect(get: "/students/new").not_to be_routable
      expect(get: "/students/#{student_id}/edit").not_to be_routable
      expect(post: "/students").not_to be_routable
      expect(patch: "/students/#{student_id}").not_to be_routable
      expect(put: "/students/#{student_id}").not_to be_routable
      expect(delete: "/students/#{student_id}").not_to be_routable
    end
  end
end
