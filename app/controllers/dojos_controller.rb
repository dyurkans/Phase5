class DojosController < ApplicationController

  def index
    @dojos = Dojo.alphabetical.paginate(:page => params[:active_dojo_page]).per_page(8)
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:inactive_dojo_page]).per_page(8)
  end

  def show
    @dojo = Dojo.find(params[:id])
    @dojo_students = @dojo.students.active.alphabetical.paginate(:page => params[:dojo_student_page]).per_page(8)
  end
  
  def new
    @dojo = Dojo.new
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      # if saved to database
      flash[:notice] = "Successfully created #{@dojo.name}."
      redirect_to @dojo # go to show dojo page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name}."
      redirect_to @dojo
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    flash[:notice] = "Successfully removed #{@dojo.name} from karate tournament system"
    redirect_to dojos_url
  end
end
