require "test_helper"

class Inventory::ProductVariantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inventory_product_variants_new_url
    assert_response :success
  end

  test "should get create" do
    get inventory_product_variants_create_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_product_variants_edit_url
    assert_response :success
  end

  test "should get update" do
    get inventory_product_variants_update_url
    assert_response :success
  end

  test "should get destroy" do
    get inventory_product_variants_destroy_url
    assert_response :success
  end
end
