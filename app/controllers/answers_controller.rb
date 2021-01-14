class AnswersController < ApplicationController
    before_action :authenticate_user!

    def create
        @question = Question.find params[:question_id]
        @answer=Answer.new answer_params
        @answer.question=@question
        @answer.user = current_user
        
        if @answer.save
            redirect_to question_path(@question), notice: 'Answer created!'
        else
            @answers=@question.answers.order(created_at: :desc)
            
            render '/questions/show'
            
        end
    end
    def destroy
        @question=Question.find params[:question_id]
        # questions/:question_id/answers/:id
        # questions/8/anaswers/1
        @answer=Answer.find params[:id]
        @answer.destroy
        redirect_to question_path(@question), notice: "Answer deleted"
    end
        
    
    private
    def answer_params
        params.require(:answer).permit(:body)
    end
end
