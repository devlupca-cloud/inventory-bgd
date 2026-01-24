'use client'
import { useState } from 'react'

interface MonthlyChartProps {
  data: Array<{
    year: number
    month: number
    monthName: string
    totalValue: number
  }>
  maxValue: number
}

export default function MonthlyChart({ data, maxValue }: MonthlyChartProps) {
  const [hoveredIndex, setHoveredIndex] = useState<number | null>(null)

  if (data.length === 0 || maxValue === 0) {
    return (
      <div className="h-80 flex flex-col items-center justify-center text-neutral-500">
        <svg className="w-16 h-16 mb-4 text-neutral-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
        </svg>
        <p className="text-sm">No spending data to display yet</p>
        <p className="text-xs text-neutral-600 mt-1">Start creating purchase requests to see trends</p>
      </div>
    )
  }

  // Take last 12 months for the chart
  const chartData = data.slice(0, 12).reverse()
  const safeMaxValue = maxValue > 0 ? maxValue : 100

  return (
    <div className="w-full">
      {/* Chart Header */}
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h3 className="text-lg font-semibold text-white">Monthly Spending Trend</h3>
          <p className="text-sm text-neutral-500 mt-1">Purchase requests spending over time</p>
        </div>
        <div className="text-right">
          <div className="text-2xl font-bold text-green-400">
            R$ {chartData.reduce((sum, m) => sum + m.totalValue, 0).toFixed(2)}
          </div>
          <div className="text-xs text-neutral-500">Total ({chartData.length} months)</div>
        </div>
      </div>

      {/* Chart */}
      <div className="relative h-80">
        {/* Y-axis labels */}
        <div className="absolute left-0 top-0 bottom-10 w-16 flex flex-col justify-between text-xs text-neutral-500 text-right pr-3">
          <span className="font-medium">R$ {safeMaxValue.toFixed(0)}</span>
          <span>R$ {(safeMaxValue * 0.75).toFixed(0)}</span>
          <span>R$ {(safeMaxValue * 0.5).toFixed(0)}</span>
          <span>R$ {(safeMaxValue * 0.25).toFixed(0)}</span>
          <span className="text-neutral-600">R$ 0</span>
        </div>

        {/* Chart area with bars */}
        <div className="ml-20 h-full pb-10 relative">
          {/* Grid lines */}
          <div className="absolute inset-0 flex flex-col justify-between pb-10">
            {[0, 0.25, 0.5, 0.75, 1].map((ratio) => (
              <div key={ratio} className="border-t border-neutral-800/50" />
            ))}
          </div>

          {/* Bars */}
          <div className="absolute inset-0 pb-10 flex items-end justify-around gap-1 px-2">
            {chartData.map((month, index) => {
              const heightPercent = (month.totalValue / safeMaxValue) * 100
              const isHovered = hoveredIndex === index
              const isCurrent = index === chartData.length - 1
              
              return (
                <div
                  key={`${month.year}-${month.month}`}
                  className="flex-1 flex flex-col items-center justify-end group relative"
                  onMouseEnter={() => setHoveredIndex(index)}
                  onMouseLeave={() => setHoveredIndex(null)}
                >
                  {/* Hover tooltip */}
                  {isHovered && (
                    <div className="absolute bottom-full mb-2 bg-neutral-800 border border-neutral-700 rounded-lg px-3 py-2 shadow-xl z-10 whitespace-nowrap animate-in fade-in slide-in-from-bottom-2 duration-200">
                      <div className="text-xs text-neutral-400">{month.monthName} {month.year}</div>
                      <div className="text-lg font-bold text-green-400">R$ {month.totalValue.toFixed(2)}</div>
                      <div className="absolute bottom-0 left-1/2 transform -translate-x-1/2 translate-y-full">
                        <div className="border-4 border-transparent border-t-neutral-800"></div>
                      </div>
                    </div>
                  )}
                  
                  {/* Bar */}
                  <div
                    className={`w-full rounded-t-lg transition-all duration-300 relative overflow-hidden ${
                      isHovered ? 'opacity-100' : 'opacity-90'
                    } ${isCurrent ? 'shadow-lg shadow-green-500/20' : ''}`}
                    style={{
                      height: `${Math.max(heightPercent, 2)}%`,
                      background: isCurrent 
                        ? 'linear-gradient(to top, rgb(34, 197, 94), rgb(74, 222, 128))'
                        : 'linear-gradient(to top, rgb(34, 197, 94), rgb(134, 239, 172))',
                    }}
                  >
                    {/* Shine effect on hover */}
                    {isHovered && (
                      <div className="absolute inset-0 bg-gradient-to-t from-white/0 to-white/20"></div>
                    )}
                    
                    {/* Glow effect for current month */}
                    {isCurrent && (
                      <div className="absolute inset-0 bg-green-400/20 animate-pulse"></div>
                    )}
                  </div>

                  {/* Value label on hover or for current month */}
                  {(isHovered || isCurrent) && month.totalValue > 0 && (
                    <div className="absolute bottom-full mb-1 text-xs font-semibold text-green-400 bg-neutral-900/80 px-2 py-0.5 rounded">
                      R$ {month.totalValue.toFixed(0)}
                    </div>
                  )}
                </div>
              )
            })}
          </div>

          {/* X-axis labels */}
          <div className="absolute bottom-0 left-0 right-0 flex justify-around gap-1 px-2">
            {chartData.map((month, index) => {
              const isCurrent = index === chartData.length - 1
              return (
                <div
                  key={`label-${month.year}-${month.month}`}
                  className="flex-1 text-center"
                >
                  <div className={`text-xs transition-colors ${
                    isCurrent 
                      ? 'text-green-400 font-semibold' 
                      : hoveredIndex === index 
                        ? 'text-white' 
                        : 'text-neutral-500'
                  }`}>
                    {month.monthName.substring(0, 3)}
                  </div>
                  <div className={`text-[10px] ${
                    isCurrent ? 'text-green-500/70' : 'text-neutral-600'
                  }`}>
                    '{month.year.toString().slice(-2)}
                  </div>
                </div>
              )
            })}
          </div>
        </div>
      </div>

      {/* Stats Footer */}
      <div className="mt-6 pt-4 border-t border-neutral-800 grid grid-cols-3 gap-4">
        <div className="text-center">
          <div className="text-xs text-neutral-500 mb-1">Average</div>
          <div className="text-lg font-semibold text-white">
            R$ {(chartData.reduce((sum, m) => sum + m.totalValue, 0) / chartData.length).toFixed(2)}
          </div>
        </div>
        <div className="text-center">
          <div className="text-xs text-neutral-500 mb-1">Highest</div>
          <div className="text-lg font-semibold text-amber-400">
            R$ {Math.max(...chartData.map(m => m.totalValue)).toFixed(2)}
          </div>
        </div>
        <div className="text-center">
          <div className="text-xs text-neutral-500 mb-1">Lowest</div>
          <div className="text-lg font-semibold text-blue-400">
            R$ {Math.min(...chartData.map(m => m.totalValue)).toFixed(2)}
          </div>
        </div>
      </div>
    </div>
  )
}
