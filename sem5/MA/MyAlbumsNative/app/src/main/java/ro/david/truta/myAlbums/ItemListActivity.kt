package ro.david.truta.myAlbums

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupWindow
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NavUtils
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.activity_item_list.*
import kotlinx.android.synthetic.main.item_list.*
import kotlinx.android.synthetic.main.item_list_content.view.*
import kotlinx.android.synthetic.main.popup_window.*
import kotlinx.android.synthetic.main.popup_window.view.*
import ro.cojocar.dan.recyclerview.R
import ro.david.truta.myAlbums.dummy.DummyContent


class ItemListActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_list)

        setSupportActionBar(toolbar)
        toolbar.title = title

        add_popup_btn.setOnClickListener { view ->
            onButtonShowPopupWindowClick(view)
        }

        setupRecyclerView(item_list)
    }

    private fun onButtonShowPopupWindowClick(view: View?) {
        // inflate the layout of the popup window
        val inflater = getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val popupView: View = inflater.inflate(R.layout.popup_window, null)

        // create the popup window
        val width = LinearLayout.LayoutParams.WRAP_CONTENT
        val height = LinearLayout.LayoutParams.WRAP_CONTENT
        val popupWindow = PopupWindow(popupView, width, height, true)

        // show the popup window
        // which view you pass in doesn't matter, it is only used for the window token
        popupWindow.showAtLocation(view, Gravity.CENTER, 0, -300)

        popupView.addPhotoBtn.setOnClickListener {
            val id: Int = DummyContent.ITEMS.size

            val photo: DummyContent.Photo = DummyContent.Photo(
                id.toString(),
                popupView.album_name_field.text.toString(),
                popupView.photo_title_field.text.toString(),
                popupView.photo_url_field.text.toString(),
                popupView.photo_date_field.text.toString()
            );

            DummyContent.ITEMS.add(photo);
            DummyContent.ITEM_MAP[id.toString()] = photo

            popupWindow.dismiss()
        }

    }

    private fun setupRecyclerView(recyclerView: RecyclerView) {
        recyclerView.adapter = SimpleItemRecyclerViewAdapter(DummyContent.ITEMS)
    }

    class SimpleItemRecyclerViewAdapter(
        private val values: List<DummyContent.Photo>
    ) : RecyclerView.Adapter<SimpleItemRecyclerViewAdapter.ViewHolder>() {

        private val onClickListener: View.OnClickListener = View.OnClickListener { v ->
            val item = v.tag as DummyContent.Photo
            val intent = Intent(v.context, ItemDetailActivity::class.java).apply {
                putExtra(ItemDetailFragment.ARG_ITEM_ID, item.id)
            }
            v.context.startActivity(intent)
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
            val view = LayoutInflater.from(parent.context)
                .inflate(R.layout.item_list_content, parent, false)
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            val item = values[position]

            holder.contentView.text = item.title

            with(holder.itemView) {
                tag = item
                setOnClickListener(onClickListener)
            }
        }

        override fun getItemCount() = values.size

        inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
            val contentView: TextView = view.content
        }
    }
}

