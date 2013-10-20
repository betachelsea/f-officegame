# coding: utf-8
#
class UsersController < ApplicationController

    def index
        @users = User.order("id desc")
        respond_to do |format|
            format.html
            format.json { render :json => @users, callback: params[:callback] }
        end
    end

    def show
        @user = User.find(params[:id])
        session_id = params[:sid]
        respond_to do |format|
            format.html
            format.json { render :json => @user, callback: params[:callback] }
        end
    end

    def new
    end

    def edit
    end

    def create
        session_id = ([*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(16).join
        @user = User.new(session_id: session_id, name: params[:name])
        if @user.save
            render :json => @user, callback: params[:callback]
        else
        end
    end

    def update
    end

    def destroy
    end

    def search
        session_id = cookies[:sid]
        @user = User.search(session_id)
        render :json => @user, callback: params[:callback]
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
