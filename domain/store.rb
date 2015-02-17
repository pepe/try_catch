# Main domain module
module Domain
  # Module for accesing the store
  module Store
    def self.model(model)
      Object.const_get(%(Domain::#{ model.capitalize }))
    end
  end
end
