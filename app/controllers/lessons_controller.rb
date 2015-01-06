class LessonsController < ApplicationController
  before_action :logged_in_user
  
  def new
    @lesson = Lesson.new
  end
  
  def create
    @lesson = current_user.lessons.build(lesson_params)
    
    if @lesson.save
      redirect_to @lesson
    else 
      render 'new'  
    end 
  end
  
  def show
    @lesson = current_user.lessons.find(params[:id])
    #binding.pry
    @lesson_translations = @lesson.translations.to_a.delete_if { |x| x.new_record? }
  end
  
  def index
    @lessons = Lesson.all 
  end
  
  def edit 
    @lesson = Lesson.find(params[:id])
  end
  
  def update 
    @lesson = Lesson.find(params[:id])
    
    if @lesson.update(lesson_params) 
      redirect_to @lesson
    else 
      render 'edit'
    end
    
  end
  
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to current_user
  end
  private 
  
  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end
end
