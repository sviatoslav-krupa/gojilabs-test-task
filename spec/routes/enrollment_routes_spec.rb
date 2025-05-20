require 'rails_helper'

RSpec.describe "Enrollment routes", type: :routing do
  it "routes POST /enrollments to enrollments#create" do
    expect(post: "/enrollments").to route_to(
                                      controller: "enrollments",
                                      action: "create"
                                    )
  end

  it "routes DELETE /enrollments/:id to enrollments#destroy" do
    expect(delete: "/enrollments/1").to route_to(
                                          controller: "enrollments",
                                          action: "destroy",
                                          id: "1"
                                        )
  end
end
