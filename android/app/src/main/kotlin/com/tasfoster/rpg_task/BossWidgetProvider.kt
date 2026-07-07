package com.tasfoster.rpg_task

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import es.antonborri.home_widget.HomeWidgetProvider

class BossWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        renderWidget(
            context, appWidgetManager, appWidgetIds,
            title = "Боссы",
            dataKey = "w_boss",
            fallback = "Откройте приложение",
            widgetData = widgetData,
        )
    }
}
