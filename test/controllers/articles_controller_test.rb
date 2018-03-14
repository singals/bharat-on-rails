# frozen_string_literal: true

require 'test_helper'
require 'loofah'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  # Custom tests
  test "should be able to get all articles" do
    get('/articles')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/article_get_all_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to get an article by id" do
    get('/articles/980190962')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/article_one_get_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'

    get('/articles/298486374')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/article_two_get_form.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

  test "should be able to save an article" do
    article_json = { 'article': { 'name': 'some valid name', 'cost': 55, 'quantity': 300, 'available_units': 150, 'mrp': 252 } }
    assert_difference('Article.count') do
      post '/articles', params: article_json
    end

    assert_response :redirect
  end

  test "should not save article without title" do
    article_invalid_json = { 'cost': 55, 'package_quantity': 300, 'availabe_units': 150, 'mrp': 252 }
    article = Article.new article_invalid_json
    assert_not article.save, "Saved the article without a title"
  end

  # auto generated tests
  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { availabe_units: @article.availabe_units, cost: @article.cost, is_active: @article.is_active, mrp: @article.mrp, name: @article.name, package_quantity: @article.package_quantity } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { availabe_units: @article.availabe_units, cost: @article.cost, is_active: @article.is_active, mrp: @article.mrp, name: @article.name, package_quantity: @article.package_quantity } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    delete article_url(@article)

    @article = Article.find(@article.id)
    assert_not @article.is_active

    assert_redirected_to articles_url
  end
end
