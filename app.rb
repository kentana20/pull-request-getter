require 'octokit'

client = Octokit::Client.new access_token: "" # GitHub Access Token

File.open("pull-requests.tsv", "w") do | f |

    #pages 
    (1..2).each do | i |
        puts "page: #{i.to_s}"
        
        pulls = client.pull_requests('', # repository name
        {:state => 'closed',
        :base => 'master',
        :sort => 'created',
        :page => i})

        pulls.each do |pull|
            next if pull.merged_at.nil?
            f.puts "#{pull.title}\t#{pull.html_url}\t#{pull.user.login}\n" 
        end

        puts client.rate_limit.remaining
    end

end
