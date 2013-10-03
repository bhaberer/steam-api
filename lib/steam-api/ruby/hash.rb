# Takes a hash and converts it into a URL encoded parameter string.
#   NOTE: this does not do any uri escaping at this point, since all args should be numeric.
# @param [Hash] params Hash of params you want broken up into a query string,
#   escaped, and returned to you.
# @return [String] Escaped parameter string to append to a url.
class Hash
  def to_params(params = {})
    params[:format] = :json
    return "?#{params.each.map{ |x| x.join('=') }.join('&')}"
  end
end
