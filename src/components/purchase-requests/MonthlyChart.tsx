'use client'
import { useState, useMemo } from 'react'
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Area, AreaChart } from 'recharts'

interface MonthlyChartProps {
  data: Array<{
    year: number
    month: number
    monthName: string
    totalValue: number
  }>
  maxValue: number
}

type PeriodOption = 3 | 6 | 12

export default function MonthlyChart({ data, maxValue }: MonthlyChartProps) {
  const [selectedPeriod, setSelectedPeriod] = useState<PeriodOption>(6)

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

  // Filter data based on selected period
  const chartData = useMemo(() => {
    return data.slice(0, selectedPeriod).reverse().map(m => ({
      ...m,
      label: `${m.monthName.substring(0, 3)} ${m.year.toString().slice(-2)}`,
      value: m.totalValue
    }))
  }, [data, selectedPeriod])

  // Custom tooltip
  const CustomTooltip = ({ active, payload }: any) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload
      return (
        <div className="bg-neutral-800 border border-neutral-700 rounded-lg px-3 py-2 shadow-xl">
          <div className="text-xs text-neutral-400">{data.monthName} {data.year}</div>
          <div className="text-lg font-bold text-green-400">R$ {data.totalValue.toFixed(2)}</div>
        </div>
      )
    }
    return null
  }

  return (
    <div className="w-full">
      {/* Chart Header with Period Filter */}
      <div className="mb-6 flex items-center justify-between">
        <div>
          <h3 className="text-lg font-semibold text-white">Monthly Spending Trend</h3>
          <p className="text-sm text-neutral-500 mt-1">Purchase requests spending over time</p>
        </div>
        
        <div className="flex items-center gap-4">
          {/* Period Filter */}
          <div className="flex items-center gap-2 bg-neutral-800 rounded-lg p-1">
            {([3, 6, 12] as PeriodOption[]).map((period) => (
              <button
                key={period}
                onClick={() => setSelectedPeriod(period)}
                className={`px-3 py-1 text-xs font-medium rounded-md transition-colors ${
                  selectedPeriod === period
                    ? 'bg-green-500 text-white'
                    : 'text-neutral-400 hover:text-white'
                }`}
              >
                {period} months
              </button>
            ))}
          </div>
          
          {/* Total */}
          <div className="text-right">
            <div className="text-2xl font-bold text-green-400">
              R$ {chartData.reduce((sum, m) => sum + m.totalValue, 0).toFixed(2)}
            </div>
            <div className="text-xs text-neutral-500">Total ({chartData.length} months)</div>
          </div>
        </div>
      </div>

      {/* Chart */}
      <div className="w-full h-80">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={chartData} margin={{ top: 10, right: 10, left: 0, bottom: 0 }}>
            <defs>
              <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="rgb(34, 197, 94)" stopOpacity={0.3}/>
                <stop offset="95%" stopColor="rgb(34, 197, 94)" stopOpacity={0.05}/>
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="rgb(38, 38, 38)" />
            <XAxis 
              dataKey="label" 
              stroke="rgb(115, 115, 115)"
              style={{ fontSize: '12px' }}
            />
            <YAxis 
              stroke="rgb(115, 115, 115)"
              style={{ fontSize: '12px' }}
              tickFormatter={(value) => `R$ ${value}`}
            />
            <Tooltip content={<CustomTooltip />} />
            <Area 
              type="monotone" 
              dataKey="value" 
              stroke="rgb(34, 197, 94)" 
              strokeWidth={2}
              fill="url(#colorValue)"
              dot={{ fill: 'rgb(34, 197, 94)', strokeWidth: 2, r: 4 }}
              activeDot={{ r: 6, fill: 'rgb(74, 222, 128)' }}
            />
          </AreaChart>
        </ResponsiveContainer>
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
