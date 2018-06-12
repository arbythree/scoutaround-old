class WikiArticlePolicy < ApplicationPolicy
  def initialize(user, wiki_article)
    @user = user
    @wiki_article = wiki_article
  end

  def destroy?
    @wiki_article.unit.role_for(user: user) == 'admin'
  end
end
