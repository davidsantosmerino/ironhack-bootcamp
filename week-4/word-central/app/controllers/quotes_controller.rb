class QuotesController < ApplicationController
  def new
    render "new"
  end
  def create
    n_paragraphs = params[:quotes][:n_paragraphs].to_i
    simpsons_quotes = [
      "It takes two to lie: one to lie and one to listen",
      "Life is just one crushing defeat after another until you just wish Flanders was dead",
      "You tried your best and you failed miserably. The lesson is: Never try"
    ]
    @quotes = []
    n_paragraphs.times {@quotes << simpsons_quotes.sample}
    render "create"
  end
end
