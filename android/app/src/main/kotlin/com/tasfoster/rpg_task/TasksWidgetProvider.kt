package com.tasfoster.rpg_task

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import es.antonborri.home_widget.HomeWidgetProvider

class TasksWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        renderWidget(
            context, appWidgetManager, appWidgetIds,
            title = "Задачи",
            dataKey = "w_tasks",
            fallback = "Откройте приложение",
            widgetData = widgetData,
        )
    }
}
