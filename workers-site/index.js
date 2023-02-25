
import { getAssetFromKV, mapRequestToAsset } from '@cloudflare/kv-asset-handler'

// Single Page Applications (SPA)
//import { getAssetFromKV, serveSinglePageApp, mapRequestToAsset } from '@cloudflare/kv-asset-handler'

const DEBUG = false

addEventListener('fetch', event => {

    try {

        event.respondWith(handleEvent(event))

    } catch (e) {

        if (DEBUG) {

            return event.respondWith(
                new Response(e.message || e.toString(), {
                status: 500,
                }),
            )

        }

        event.respondWith(new Response('Internal Error', { status: 500 }))

    }

})

async function handleEvent(event) {

    const url = new URL(event.request.url)

    let options = {}

    // Example to strip a prefix from the URL
    //options.mapRequestToAsset = handlePrefix(/^\/PREFIX_TO_STRIP/)

    try {

        if (DEBUG) {

            // customize caching
            options.cacheControl = {
                bypassCache: true,
            }

        }

        const page = await getAssetFromKV(event, options)

        // Single Page Applications (SPA)
        //const response = await getAssetFromKV(event, { mapRequestToAsset: serveSinglePageApp }

        // allow headers to be altered
        const response = new Response(page.body, page)

        response.headers.set('X-XSS-Protection', '1; mode=block')
        response.headers.set('X-Content-Type-Options', 'nosniff')
        response.headers.set('X-Frame-Options', 'DENY')
        response.headers.set('Referrer-Policy', 'unsafe-url')
        response.headers.set('Feature-Policy', 'none')

        return response

    } catch (e) {

        // if an error is thrown try to serve the asset at 404.html
        if (!DEBUG) {

            try {

                let notFoundResponse = await getAssetFromKV(event, {
                    mapRequestToAsset: req => new Request(`${new URL(req.url).origin}/404.html`, req),
                })

                return new Response(notFoundResponse.body, { ...notFoundResponse, status: 404 })

            } catch (e) {}

        }

        return new Response(e.message || e.toString(), { status: 500 })

    }

}

// Strip the provided prefix from the URL
function handlePrefix(prefix) {

    return request => {

        // compute the default (e.g. / -> index.html)
        let defaultAssetKey = mapRequestToAsset(request)
        let url = new URL(defaultAssetKey.url)

        // strip the prefix from the path for lookup
        url.pathname = url.pathname.replace(prefix, '/')

        // inherit all other props from the default request
        return new Request(url.toString(), defaultAssetKey)

    }

}
