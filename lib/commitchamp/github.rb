module Commitchamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      token = prompt("What is your auth token?")
      @headers = {
        "Authorization"     => "token #{token}",
        "User-Agent"        => "HTTParty"
      }
    end

    def get_contributors(owner, repo)
      Github.get("/repos/#{owner}/#{repo}/stats/contributors", headers: @headers)
    end

    def get_pretty_stats(owner, repo)
      response = self.get_contributors(owner, repo)
      response.map { |contribution| extract_results(contribution) }
    end

    def extract_results(contribution)
      user = get_author(contribution)
      additions = get_stats(contribution, "a")
      deletions = get_stats(contribution, "d")
      changes   = get_stats(contribution, "c")
      { user => [additions, deletions, changes] }
    end

    private
    def get_author(contribution)
      contribution["author"]["login"]
      # author_data = contribution["author"]
      # author_data["login"]
    end

    def get_stats(contribution, stat)
      weeks = contribution["weeks"]
      weeks.inject(0) { |sum, item| sum + item[stat] }
    end

    def prompt(message)
      puts message
      gets.chomp
    end
  end
end
