-- Migration: Make site_id optional in purchase_requests
-- This allows creating general purchase requests without a specific requesting site

ALTER TABLE purchase_requests
ALTER COLUMN site_id DROP NOT NULL;

COMMENT ON COLUMN purchase_requests.site_id IS
'Optional site that created this purchase request (for tracking/organization purposes). NULL means it is a general purchase request. Items will be distributed to target sites specified in purchase_request_items.';
