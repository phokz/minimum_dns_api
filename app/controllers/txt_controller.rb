# frozen_string_literal: true

class TxtController < ApplicationController
  before_action :load_domain

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
    domain_parts = params[:domain].split('.')
    while !domain_parts.size.zero? do
        domain = domain_parts.join('.')
        @domain = Domain.find_by_name(domain)
        break if !@domain.nil?
        domain_parts.shift
    end

    if @domain.nil?
       render plain: 'Domain not found.'
       return false
    end

    puts "Domain found: #{@domain.id}"
  end
end
