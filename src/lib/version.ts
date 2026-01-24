// Application version
// Update this when releasing a new version
export const APP_VERSION = '1.0.2';

// Version metadata
export const VERSION_INFO = {
  version: APP_VERSION,
  buildDate: process.env.NEXT_PUBLIC_BUILD_DATE || new Date().toISOString(),
  environment: process.env.NODE_ENV || 'development',
} as const;
