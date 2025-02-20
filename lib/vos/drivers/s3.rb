require 'aws'
require 'vos/drivers/s3_vfs_storage'

module Vos
  module Drivers
    class S3
      attr_accessor :box
      attr_reader :connection, :bucket

      def initialize options = {}
        options = options.clone
        @bucket_name = options.delete(:bucket) || raise("S3 bucket not provided!")
        @acl = options.delete(:acl) || :public_read
        @options = options
      end


      #
      # Establishing SSH channel
      #
      def open &block
        if block
          if connection
            block.call self
          else
            begin
              open
              block.call self
            ensure
              close
            end
          end
        else
          unless connection
            @connection = ::Aws::S3::Client.new self.options.clone
            @bucket = @connection.list_buckets
              .buckets
              .select { |bucket| bucket.name == bucket_name}
              .first
          end
        end
      end

      def close; end

      #
      # Vfs
      #
      include S3VfsStorage


      #
      # Miscellaneous
      #
      def inspect; "https://#{bucket_name}.s3.amazonaws.com" end
      alias_method :to_s, :inspect

      def _clear
        bucket.objects.each{|o| o.delete}
      end

      protected
        attr_reader :options, :bucket_name, :acl
    end
  end
end
