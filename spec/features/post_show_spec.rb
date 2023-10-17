require 'rails_helper'

RSpec.feature 'PostShows', type: :feature do
  before :each do
    @user1 = User.create(name: 'Alexander', bio: 'Student from Afg',
                         photo: 'https://img.freepik.com/free-photo/view-adorable-kitten-with-simple-background_23-2150758084.jpg',
                         post_counter: 2)

    @post = Post.create(author_id: @user1.id, title: 'First Post',
                        text: 'First', comments_counter: 3, likes_counter: 0)

    @comment1 = Comment.create(user_id: @user1.id, post_id: @post.id, text: 'This is first comment')
    @comment2 = Comment.create(user_id: @user1.id, post_id: @post.id, text: 'This is Second comment')
    @comment3 = Comment.create(user_id: @user1.id, post_id: @post.id, text: 'This is Third comment')
  end

  it 'Shows the content of the post#show page' do
    visit user_post_path(@user1, @post)
    # I can see the post's title
    expect(page).to have_content(@post.title)
    # I can see who wrote the post
    expect(page).to have_content(@user1.name)
    # I can see how many comments it has
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    # I can see how many likes it has
    expect(page).to have_content("Likes: #{@post.likes_counter}")
    # I can see the post body
    expect(page).to have_content(@post.text)
    within('.post-comments-container') do
      # I can see the username of each commentor
      expect(page).to have_content(@user1.name)
      # I can see the comment each commentor left
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end
  end
end
