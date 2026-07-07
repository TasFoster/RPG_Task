package com.tasfoster.rpg_task

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews

/** Общий рендер виджета: заголовок + контент из сохранённых данных, тап открывает приложение. */
internal fun renderWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetIds: IntArray,
    title: String,
    dataKey: String,
    fallback: String,
    widgetData: SharedPreferences,
) {
    val content = widgetData.getString(dataKey, fallback) ?: fallback
    appWidgetIds.forEach { id ->
        val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
            setTextViewText(R.id.widget_title, title)
            setTextViewText(R.id.widget_content, content)
            val intent = Intent(context, MainActivity::class.java)
            val flags = PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            val pending = PendingIntent.getActivity(context, 0, intent, flags)
            setOnClickPendingIntent(R.id.widget_root, pending)
        }
        appWidgetManager.updateAppWidget(id, views)
    }
}
