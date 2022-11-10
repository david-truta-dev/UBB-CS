package ro.david.truta.myAlbums.dummy

import java.util.*
import kotlin.collections.ArrayList

object DummyContent {

    val ITEMS: MutableList<Photo> = ArrayList()

    val ITEM_MAP: MutableMap<String, Photo> = HashMap()

    private const val COUNT = 25

    init {

        // Add some sample items.
        for (i in 1..COUNT) {
            addItem(
                createDummyItem(
                    i,
                    "https://publicdomainarchive.com/wp-content/uploads/2017/01/public-domain-images-free-stock-photos001-1000x750.jpg"
                )
            )
        }
    }

    private fun addItem(item: Photo) {
        ITEMS.add(item)
        ITEM_MAP[item.id] = item
    }

    private fun createDummyItem(position: Int, url: String): Photo {
        return Photo(position.toString(), 0, "Photo $position", url, "date$position")
    }

    private fun makeDetails(position: Int): String {
        val builder = StringBuilder()
        builder.append("Details about Item: ").append(position)
        for (i in 0 until position) {
            builder.append("\nMore details information here.")
        }
        return builder.toString()
    }

    data class Photo(
        val id: String,
        val albumId: Int,
        val title: String,
        val url: String,
        val date: String,
    ) {
        override fun toString(): String = title
    }
}
