# frozen_string_literal: true

class TxtController < ApplicationController
  before_action :load_domain
  skip_before_action :verify_authenticity_token

  def set
    r = @domain.records.where(type: 'TXT').find_by_name(params[:domain])
    r = Record.new(type: 'TXT', domain: @domain, name: params[:domain], ttl: 300) if r.nil?

    content = params[:txtvalue]
    r.content = content

    result = r.save ? 'OK' : r.errors.map(&:to_s).join(':')
    render plain: result
  end

  def destroy
    r = @domain.records.where(type: 'TXT').find_by_name(params[:domain])
    if !r.nil?
      r.destroy
      render plain: 'OK - Record removed.'
    else
      render plain: 'Record not found.'
    end
  end

  def load_domain
    domain_tld = params[:domain].split('.')[-2..-1].join('.')
    puts "Domain: #{domain_tld}"
    @domain = Domain.find_by_name(domain_tld)
    return false if @domain.nil?

    puts "Domain found: #{@domain.id}"
  end
end
