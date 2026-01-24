export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      sites: {
        Row: {
          id: string
          name: string
          address: string | null
          supervisor_name: string | null
          supervisor_phone: string | null
          is_master: boolean
          created_at: string
          updated_at: string
          deleted_at: string | null
        }
        Insert: {
          id?: string
          name: string
          address?: string | null
          supervisor_name?: string | null
          supervisor_phone?: string | null
          is_master?: boolean
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          address?: string | null
          supervisor_name?: string | null
          supervisor_phone?: string | null
          is_master?: boolean
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
      }
      products: {
        Row: {
          id: string
          name: string
          unit: string
          base_unit: string
          units_per_package: number
          created_at: string
          updated_at: string
          deleted_at: string | null
        }
        Insert: {
          id?: string
          name: string
          unit: string
          base_unit?: string
          units_per_package?: number
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          unit?: string
          base_unit?: string
          units_per_package?: number
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
      }
      site_inventory: {
        Row: {
          site_id: string
          product_id: string
          quantity_on_hand: number
          quantity_packages: number
          quantity_loose_units: number
          last_updated: string
        }
        Insert: {
          site_id: string
          product_id: string
          quantity_on_hand?: number
          quantity_packages?: number
          quantity_loose_units?: number
          last_updated?: string
        }
        Update: {
          site_id?: string
          product_id?: string
          quantity_on_hand?: number
          quantity_packages?: number
          quantity_loose_units?: number
          last_updated?: string
        }
      }
      site_product_min_levels: {
        Row: {
          site_id: string
          product_id: string
          min_level: number
        }
        Insert: {
          site_id: string
          product_id: string
          min_level: number
        }
        Update: {
          site_id?: string
          product_id?: string
          min_level?: number
        }
      }
      stock_movements: {
        Row: {
          id: string
          site_id: string
          product_id: string
          movement_type: 'IN' | 'OUT' | 'TRANSFER_OUT' | 'TRANSFER_IN'
          quantity: number
          transfer_to_site_id: string | null
          transfer_movement_id: string | null
          notes: string | null
          created_by: string
          created_at: string
        }
        Insert: {
          id?: string
          site_id: string
          product_id: string
          movement_type: 'IN' | 'OUT' | 'TRANSFER_OUT' | 'TRANSFER_IN'
          quantity: number
          transfer_to_site_id?: string | null
          transfer_movement_id?: string | null
          notes?: string | null
          created_by?: string
          created_at?: string
        }
        Update: {
          id?: string
          site_id?: string
          product_id?: string
          movement_type?: 'IN' | 'OUT' | 'TRANSFER_OUT' | 'TRANSFER_IN'
          quantity?: number
          transfer_to_site_id?: string | null
          transfer_movement_id?: string | null
          notes?: string | null
          created_by?: string
          created_at?: string
        }
      }
      purchase_requests: {
        Row: {
          id: string
          site_id: string
          status: 'draft' | 'submitted' | 'approved' | 'rejected' | 'fulfilled' | 'partially_fulfilled'
          requested_by: string
          approved_by: string | null
          approved_at: string | null
          notes: string | null
          created_at: string
          updated_at: string
          deleted_at: string | null
        }
        Insert: {
          id?: string
          site_id: string
          status?: 'draft' | 'submitted' | 'approved' | 'rejected' | 'fulfilled' | 'partially_fulfilled'
          requested_by: string
          approved_by?: string | null
          approved_at?: string | null
          notes?: string | null
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
        Update: {
          id?: string
          site_id?: string
          status?: 'draft' | 'submitted' | 'approved' | 'rejected' | 'fulfilled' | 'partially_fulfilled'
          requested_by?: string
          approved_by?: string | null
          approved_at?: string | null
          notes?: string | null
          created_at?: string
          updated_at?: string
          deleted_at?: string | null
        }
      }
      purchase_request_items: {
        Row: {
          id: string
          purchase_request_id: string
          product_id: string
          quantity_requested: number
          quantity_received: number
          unit_price: number | null
          notes: string | null
          target_site_id: string | null
        }
        Insert: {
          id?: string
          purchase_request_id: string
          product_id: string
          quantity_requested: number
          quantity_received?: number
          unit_price?: number | null
          notes?: string | null
          target_site_id?: string | null
        }
        Update: {
          id?: string
          purchase_request_id?: string
          product_id?: string
          quantity_requested?: number
          quantity_received?: number
          unit_price?: number | null
          notes?: string | null
          target_site_id?: string | null
        }
      }
      user_profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          role: 'viewer' | 'supervisor' | 'manager' | 'owner'
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          role?: 'viewer' | 'supervisor' | 'manager' | 'owner'
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          role?: 'viewer' | 'supervisor' | 'manager' | 'owner'
          created_at?: string
          updated_at?: string
        }
      }
      site_user_roles: {
        Row: {
          id: string
          user_id: string
          site_id: string
          role: 'supervisor'
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          site_id: string
          role?: 'supervisor'
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          site_id?: string
          role?: 'supervisor'
          created_at?: string
        }
      }
    }
    Views: {
      low_stock_alerts: {
        Row: {
          site_id: string
          site_name: string
          product_id: string
          product_name: string
          quantity_on_hand: number
          min_level: number
          shortage: number
        }
      }
    }
    Functions: {
      rpc_register_in: {
        Args: {
          p_site_id: string
          p_product_id: string
          p_quantity: number
          p_notes?: string | null
        }
        Returns: { success: boolean; message?: string }
      }
      rpc_register_out: {
        Args: {
          p_site_id: string
          p_product_id: string
          p_quantity: number
          p_notes?: string | null
        }
        Returns: { success: boolean; message?: string }
      }
      rpc_transfer_between_sites: {
        Args: {
          p_from_site_id: string
          p_to_site_id: string
          p_product_id: string
          p_quantity: number
          p_notes?: string | null
        }
        Returns: { success: boolean; message?: string }
      }
      rpc_approve_purchase_request: {
        Args: {
          p_request_id: string
        }
        Returns: { success: boolean; message?: string }
      }
      rpc_receive_purchase_request: {
        Args: {
          p_request_id: string
          p_items_received: Array<{
            item_id: string
            quantity_received: number
            unit_price?: number | null
          }>
        }
        Returns: { success: boolean; message?: string }
      }
    }
  }
}
