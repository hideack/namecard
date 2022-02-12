require 'test_helper'

class KeychainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @keychain = keychains(:one)
  end

  test "should get index" do
    get keychains_url
    assert_response :success
  end

  test "should get new" do
    get new_keychain_url
    assert_response :success
  end

  test "should create keychain" do
    assert_difference('Keychain.count') do
      post keychains_url, params: { keychain: {  } }
    end

    assert_redirected_to keychain_url(Keychain.last)
  end

  test "should show keychain" do
    get keychain_url(@keychain)
    assert_response :success
  end

  test "should get edit" do
    get edit_keychain_url(@keychain)
    assert_response :success
  end

  test "should update keychain" do
    patch keychain_url(@keychain), params: { keychain: {  } }
    assert_redirected_to keychain_url(@keychain)
  end

  test "should destroy keychain" do
    assert_difference('Keychain.count', -1) do
      delete keychain_url(@keychain)
    end

    assert_redirected_to keychains_url
  end
end
