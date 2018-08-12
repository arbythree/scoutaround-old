class Units::WikiArticlesController < AuthenticatedController
  before_action :find_unit

  def index
    @wiki_article = @unit.primary_wiki_article

    # create if needed
    if @wiki_article.nil?
      @wiki_article = WikiArticle.create(title: 'New Wiki Page')
      @unit.update_attributes(primary_wiki_article: @wiki_article)
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end
end
