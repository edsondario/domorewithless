require "test_helper"

class AfastamentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get afastamentos_index_url
    assert_response :success
  end

  test "should get create" do
    get afastamentos_create_url
    assert_response :success
  end
end
