class UsersController < ApplicationController
  def index
  	@users = [
      User.new(
        id: 1,
        name: 'Dmitry',
        username: 'kartinich',
        avatar_url: 'https://avatars1.githubusercontent.com/u/45013949?s=460&u=bbbb1ab7109d55f2b32365be57bce3518b142541&v=4'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
  	@user = User.new(
      name: 'Dmitry',
      username: 'kartinich',
      avatar_url: 'https://avatars1.githubusercontent.com/u/45013949?s=460&u=bbbb1ab7109d55f2b32365be57bce3518b142541&v=4'
  	)

  	@questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
