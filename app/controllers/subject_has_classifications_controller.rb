class SubjectHasClassificationsController < ApplicationController
  load_and_authorize_resource
  before_filter :get_subject
  before_filter :get_classification

  # GET /subject_has_classifications
  # GET /subject_has_classifications.json
  def index
    case when @subject
      @subject_has_classifications = @subject.subject_has_classifications.page(params[:page])
    when @classification
      @subject_has_classifications = @classification.subject_has_classifications.page(params[:page])
    else
      @subject_has_classifications = SubjectHasClassification.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @subject_has_classifications }
    end
  end

  # GET /subject_has_classifications/1
  # GET /subject_has_classifications/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @subject_has_classification }
    end
  end

  # GET /subject_has_classifications/new
  # GET /subject_has_classifications/new.json
  def new
    @subject_has_classification = SubjectHasClassification.new
    @subject_has_classification.subject = @subject
    @subject_has_classification.classification = @classification

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @subject_has_classification }
    end
  end

  # GET /subject_has_classifications/1/edit
  def edit
  end

  # POST /subject_has_classifications
  # POST /subject_has_classifications.json
  def create
    @subject_has_classification = SubjectHasClassification.new(params[:subject_has_classification])

    respond_to do |format|
      if @subject_has_classification.save
        format.html { redirect_to @subject_has_classification, :notice => t('controller.successfully_created', :model => t('activerecord.models.subject_has_classification')) }
        format.json { render :json => @subject_has_classification, :status => :created, :location => @subject_has_classification }
      else
        format.html { render :action => "new" }
        format.json { render :json => @subject_has_classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subject_has_classifications/1
  # PUT /subject_has_classifications/1.json
  def update
    respond_to do |format|
      if @subject_has_classification.update_attributes(params[:subject_has_classification])
        format.html { redirect_to @subject_has_classification, :notice => t('controller.successfully_updated', :model => t('activerecord.models.subject_has_classification')) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @subject_has_classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_has_classifications/1
  # DELETE /subject_has_classifications/1.json
  def destroy
    @subject_has_classification.destroy

    respond_to do |format|
      format.html {
        if @subject
          redirect_to subject_subject_has_classifications_url(@subject)
        elsif @classification
          redirect_to classification_subject_has_classifications_url(@classification)
        else
          redirect_to subject_has_classifications_url
        end
      }
      format.json { head :no_content }
    end
  end
end
