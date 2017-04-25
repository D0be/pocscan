class SearchController < ApplicationController

    def index
        @keywords = params[:keywords]
        if @keywords.nil? or @keywords.empty?   
            @vuls = Vul.paginate(page: params[:page], per_page: 9)
        else
            search_params = {
                query: {
                    simple_query_string: {
                        query: @keywords,
                        default_operator: 'AND',
                        minimum_should_match: '100%',
                        fields: %w(name description search_key)
                    }
                },
                highlight: {
                    pre_tags: ['[h]'],
                    post_tags: ['[h]'],
                    fields: { name: {}, description: {}, search_key: {}, file: {} }
                }
            }
            @es_vulns = Elasticsearch::Model.search(search_params,[Vul]).paginate(page: params[:page], per_page: 9)
            @vuls = @es_vulns.records
        end
        
    end
end
