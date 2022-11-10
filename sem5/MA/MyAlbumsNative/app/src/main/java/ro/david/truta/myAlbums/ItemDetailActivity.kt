package ro.david.truta.myAlbums

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.widget.LinearLayout
import android.widget.PopupWindow
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NavUtils
import kotlinx.android.synthetic.main.activity_item_detail.*
import kotlinx.android.synthetic.main.popup_window.view.*
import ro.cojocar.dan.recyclerview.R
import ro.david.truta.myAlbums.dummy.DummyContent

class ItemDetailActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_detail)
        setSupportActionBar(detail_toolbar)

        // Show the Up button in the action bar.
        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        if (savedInstanceState == null) {
            // Create the detail fragment and add it to the activity
            // using a fragment transaction.
            val fragment = ItemDetailFragment().apply {
                arguments = Bundle().apply {
                    putString(
                        ItemDetailFragment.ARG_ITEM_ID,
                        intent.getStringExtra(ItemDetailFragment.ARG_ITEM_ID)
                    )
                }
            }

            supportFragmentManager.beginTransaction()
                .add(R.id.item_detail_container, fragment)
                .commit()
        }

        add_popup_btn.setOnClickListener {
            deletePhoto(intent.getStringExtra(ItemDetailFragment.ARG_ITEM_ID).toString())
        }

        update_popup.setOnClickListener { view ->
            updatePhoto(intent.getStringExtra(ItemDetailFragment.ARG_ITEM_ID).toString(), view)
        }
    }

    private fun deletePhoto(id: String) {
        DummyContent.ITEM_MAP.remove(id)
        DummyContent.ITEMS.remove(DummyContent.ITEMS.find { it.id == id })
        NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java));
    }

    private fun updatePhoto(id: String, view: View) {
        onButtonShowPopupWindowClick(id, view)
    }

    private fun onButtonShowPopupWindowClick(id: String, view: View?) {
        // inflate the layout of the popup window
        val inflater = getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val popupView: View = inflater.inflate(R.layout.popup_window, null)

        // create the popup window
        val width = LinearLayout.LayoutParams.WRAP_CONTENT
        val height = LinearLayout.LayoutParams.WRAP_CONTENT
        val popupWindow = PopupWindow(popupView, width, height, true)

        popupView.addPhotoBtn.text = "UPDATE";

        // show the popup window
        // which view you pass in doesn't matter, it is only used for the window token
        popupWindow.showAtLocation(view, Gravity.CENTER, 0, -300)

        popupView.addPhotoBtn.setOnClickListener {
            DummyContent.ITEM_MAP.remove(id)
            DummyContent.ITEMS.remove(DummyContent.ITEMS.find { it.id == id })

            val photo: DummyContent.Photo = DummyContent.Photo(
                id,
                popupView.album_name_field.text.toString(),
                popupView.photo_title_field.text.toString(),
                popupView.photo_url_field.text.toString(),
                popupView.photo_date_field.text.toString()
            );

            DummyContent.ITEMS.add(photo);
            DummyContent.ITEM_MAP[id] = photo

            popupWindow.dismiss()
            NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java));
        }
    }

    override fun onOptionsItemSelected(item: MenuItem) =
        when (item.itemId) {
            android.R.id.home -> {
                // This ID represents the Home or Up button. In the case of this
                // activity, the Up button is shown. Use NavUtils to allow users
                // to navigate up one level in the application structure. For
                // more details, see the Navigation pattern on Android Design:
                //
                // http://developer.android.com/design/patterns/navigation.html#up-vs-back

                NavUtils.navigateUpTo(this, Intent(this, ItemListActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
}
