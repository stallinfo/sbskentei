require "test_helper"

class KmondaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kmondai = kmondais(:one)
  end

  test "should get index" do
    get kmondais_url
    assert_response :success
  end

  test "should get new" do
    get new_kmondai_url
    assert_response :success
  end

  test "should create kmondai" do
    assert_difference('Kmondai.count') do
      post kmondais_url, params: { kmondai: { answer: @kmondai.answer, explanation: @kmondai.explanation, level: @kmondai.level, number: @kmondai.number, order: @kmondai.order, question: @kmondai.question, suborder: @kmondai.suborder, system: @kmondai.system } }
    end

    assert_redirected_to kmondai_url(Kmondai.last)
  end

  test "should show kmondai" do
    get kmondai_url(@kmondai)
    assert_response :success
  end

  test "should get edit" do
    get edit_kmondai_url(@kmondai)
    assert_response :success
  end

  test "should update kmondai" do
    patch kmondai_url(@kmondai), params: { kmondai: { answer: @kmondai.answer, explanation: @kmondai.explanation, level: @kmondai.level, number: @kmondai.number, order: @kmondai.order, question: @kmondai.question, suborder: @kmondai.suborder, system: @kmondai.system } }
    assert_redirected_to kmondai_url(@kmondai)
  end

  test "should destroy kmondai" do
    assert_difference('Kmondai.count', -1) do
      delete kmondai_url(@kmondai)
    end

    assert_redirected_to kmondais_url
  end
end
