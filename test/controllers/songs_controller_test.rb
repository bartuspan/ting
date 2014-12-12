require 'test_helper'

class SongsControllerTest < ActionController::TestCase

  def setup
    @song = songs(:one)
    @other_song = songs(:two)
  end

  test "shoud redirect create when not loged in" do 
    assert_no_difference 'Song.count' do 
      post :create, song: { s_id: 1, content: "lalala" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when  not loged in" do
    assert_no_difference "Song.count" do 
      delete :destroy, id: @song
    end
    assert_redirected_to login_url
  end

  test "should redirect edit for wrong song" do 
    login_user(users(:paul))
    get :edit, id: @other_song
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update for wrong song" do
    login_user(users(:paul))
    patch :update, id: @other_song, song: { content: "@other_song.content" }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should destroy for wrong song" do
    login_user(users(:paul))
    assert_no_difference "Song.count" do
      begin
        delete :destroy, id: @other_song
      rescue ActiveRecord::RecordNotFound
      end
      assert_redirected_to root_path
    end
  end

end