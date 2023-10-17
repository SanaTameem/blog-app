require 'rails_helper'

RSpec.feature 'UserIndices', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Sanam',
      bio: 'Student from Afg',
      photo: 'https://img.freepik.com/free-photo/view-adorable-kitten-with-simple-background_23-2150758084.jpg',
      post_counter: 0
    )

    @user2 = User.create(
      name: 'Marwa',
      bio: 'Doctor from Afg',
      photo: 'https://www.shutterstock.com/image-photo/british-shorthair-kitten-silver-color-260nw-1510641710.jpg',
      post_counter: 1
    )
  end

  it 'Shows the content of the user#index page' do
    visit root_path
    # I can see the username of all other users.
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    # I can see the profile picture for each user.
    expect(page).to have_css("img[src='#{@user1.photo}']")
    expect(page).to have_css("img[src='#{@user2.photo}']")
    # I can see the number of posts each user has written.
    expect(page).to have_content("Number of posts : #{@user1.post_counter}")
    expect(page).to have_content("Number of posts : #{@user2.post_counter}")
    # When I click on a user, I am redirected to that user's show page.
    click_link @user1.name
    expect(page).to have_current_path(user_path(@user1))
  end
end
