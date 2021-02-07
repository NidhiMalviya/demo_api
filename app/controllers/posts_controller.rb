class PostsController < ApplicationController
    # before_action :find_user
    #, except: %i[create index]

    def index
        
        @posts =  Post.all 
        render json: @posts
    end

    def create
       debugger
        @post =  Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: { errors: @post.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def update
        unless @post.update(post_params)
            render json: { errors: @post.errors.full_messages }
        end
    end
    
    def show 
        render json: @post
    end

    def destroy
        @post.destroy
    end


    private

    def find_user
        @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: 'Post not found' }, status: :not_found
    end

    def post_params
        params.permit(:title, :text)
    end

    


end
