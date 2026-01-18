'use client'

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
  if (data.length === 0 || maxValue === 0) {
    return (
      <div className="h-64 flex items-center justify-center text-neutral-500">
        No data to display
      </div>
    )
  }

  // Take last 12 months for the chart
  const chartData = data.slice(0, 12).reverse()
  const chartHeight = 200
  const chartWidth = 100
  const padding = 40

  // Calculate points for the line
  const points = chartData.map((month, index) => {
    const divisor = chartData.length > 1 ? (chartData.length - 1) : 1
    const x = padding + ((index / divisor) * (chartWidth - 2 * padding))
    const y = chartHeight - padding - ((month.totalValue / maxValue) * (chartHeight - 2 * padding))
    return { x, y, month, value: month.totalValue }
  })

  // Create SVG path for the line
  const pathData = points.length > 1
    ? points.map((point, index) => {
        return `${index === 0 ? 'M' : 'L'} ${point.x} ${point.y}`
      }).join(' ')
    : points.length === 1
    ? `M ${points[0].x} ${points[0].y}`
    : ''

  // Create area path (for gradient fill)
  const areaPath = points.length > 0
    ? `${pathData} L ${points[points.length - 1].x} ${chartHeight - padding} L ${points[0].x} ${chartHeight - padding} Z`
    : ''

  return (
    <div className="w-full">
      <div className="relative" style={{ height: `${chartHeight}px` }}>
        {/* Y-axis labels */}
        <div className="absolute left-0 top-0 bottom-8 flex flex-col justify-between text-xs text-neutral-500 pr-2">
          <span>R$ {maxValue.toFixed(0)}</span>
          <span>R$ {(maxValue * 0.75).toFixed(0)}</span>
          <span>R$ {(maxValue * 0.5).toFixed(0)}</span>
          <span>R$ {(maxValue * 0.25).toFixed(0)}</span>
          <span>R$ 0</span>
        </div>

        {/* Chart area */}
        <div className="ml-16 h-full relative">
          {/* SVG Chart */}
          <svg
            width="100%"
            height="100%"
            viewBox={`0 0 ${chartWidth} ${chartHeight}`}
            preserveAspectRatio="none"
            className="absolute inset-0"
          >
            {/* Grid lines */}
            {[0, 0.25, 0.5, 0.75, 1].map((ratio) => {
              const y = padding + (ratio * (chartHeight - 2 * padding))
              return (
                <line
                  key={ratio}
                  x1={padding}
                  y1={y}
                  x2={chartWidth - padding}
                  y2={y}
                  stroke="rgb(38, 38, 38)"
                  strokeWidth="1"
                />
              )
            })}

            {/* Gradient area fill */}
            <defs>
              <linearGradient id="areaGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" stopColor="rgb(34, 197, 94)" stopOpacity="0.3" />
                <stop offset="100%" stopColor="rgb(34, 197, 94)" stopOpacity="0.05" />
              </linearGradient>
            </defs>
            <path
              d={areaPath}
              fill="url(#areaGradient)"
            />

            {/* Line */}
            {points.length > 1 && (
              <path
                d={pathData}
                fill="none"
                stroke="rgb(34, 197, 94)"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            )}

            {/* Data points */}
            {points.map((point, index) => (
              <g key={index}>
                <circle
                  cx={point.x}
                  cy={point.y}
                  r="4"
                  fill="rgb(34, 197, 94)"
                  className="hover:r-6 transition-all cursor-pointer"
                />
                <title>
                  {point.month.monthName} {point.month.year}: R$ {point.value.toFixed(2)}
                </title>
              </g>
            ))}
          </svg>

          {/* X-axis labels */}
          <div className="absolute bottom-0 left-0 right-0 flex justify-between px-2" style={{ paddingLeft: `${(padding / chartWidth) * 100}%`, paddingRight: `${(padding / chartWidth) * 100}%` }}>
            {chartData.map((month, index) => (
              <div
                key={`${month.year}-${month.month}`}
                className="text-xs text-neutral-400 text-center"
                style={{ width: `${100 / chartData.length}%` }}
              >
                {month.monthName.substring(0, 3)} {month.year.toString().slice(-2)}
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Legend */}
      <div className="mt-4 pt-4 border-t border-neutral-800">
        <div className="flex items-center justify-center space-x-6 text-sm text-neutral-400">
          <div className="flex items-center space-x-2">
            <div className="w-4 h-4 bg-green-500 rounded-full"></div>
            <span>Total Spent (R$)</span>
          </div>
        </div>
      </div>
    </div>
  )
}
