class TranslationsController < ApplicationController
  
  def new
    @lesson = Lesson.find(params[:lesson_id])
  end
  
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @translation = @lesson.translations.create(translations_params)
   
    redirect_to lesson_path(@lesson)

  end
  
  def destroy
    @lesson = Lesson.find(params[:lesson_id])
    @translation = @lesson.translations.find(params[:id])
    @translation.destroy
    
    redirect_to lesson_path(@lesson)
  end
  
  private 
  def translations_params
    params.require(:translation).permit(:first_language, :second_language, :tip, :example)
  end
end
