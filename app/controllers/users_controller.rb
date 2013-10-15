# coding: utf-8
#
class UsersController < ApplicationController

    def index
        @user = User.order("id")
        respond_to do |format|
            format.html
            format.json { render :json => @user }
        end
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
    end

    def update
    end

    def destroy
    end

    private

    def create_json(data)
        data = [data] unless data.class == Array
        data = data.inject([]){ |arr, obj|
            arr << {
                :id => obj.id,
                :created_at => obj.created_at
            }; arr
        }
        { :data => data }.to_json
    end

end
