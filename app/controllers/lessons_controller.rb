class LessonsController < ApplicationController
  
  def new
    @lesson = Lesson.new
  end
  
  def create
    @lesson = Lesson.new(lesson_params)
    
    if @lesson.save
      redirect_to @lesson
    else 
      render 'new'  
    end 
  end
  
  def show
    @lesson = Lesson.find(params[:id])
    binding.pry
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
    
    redirect_to lessons_path
  end
  private 
  
  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end
end
