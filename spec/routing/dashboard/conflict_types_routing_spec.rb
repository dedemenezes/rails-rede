require "rails_helper"

RSpec.describe Dashboard::ConflictTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dashboard/conflict_types").to route_to("dashboard/conflict_types#index")
    end

    it "routes to #new" do
      expect(get: "/dashboard/conflict_types/new").to route_to("dashboard/conflict_types#new")
    end

    it "routes to #show" do
      expect(get: "/dashboard/conflict_types/1").to route_to("dashboard/conflict_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/dashboard/conflict_types/1/edit").to route_to("dashboard/conflict_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/dashboard/conflict_types").to route_to("dashboard/conflict_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/dashboard/conflict_types/1").to route_to("dashboard/conflict_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/dashboard/conflict_types/1").to route_to("dashboard/conflict_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/dashboard/conflict_types/1").to route_to("dashboard/conflict_types#destroy", id: "1")
    end
  end
end
